import { View, StyleSheet, Button } from 'react-native';
import { NativeModules } from 'react-native';

const { VibrateManager } = NativeModules;
const onDragStart = () => {
  VibrateManager.prepareHaptic(); // Chuẩn bị trước
  VibrateManager.hapticLight(); // Rung khi bắt đầu kéo
};
const onDragMove = () => {
  VibrateManager.hapticSelectionPrepared(); // Rung nhẹ - tốt nhất cho reorder
};

// Khi thả item
const onDragEnd = () => {
  VibrateManager.hapticMedium(); // Rung xác nhận
};
export default function App() {
  return (
    <View style={styles.container}>
      <Button title="onDragStart" onPress={onDragStart} />
      <Button title="onDragMove" onPress={onDragMove} />
      <Button title="onDragEnd" onPress={onDragEnd} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
