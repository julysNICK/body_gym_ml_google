import 'package:body_gym/class/feedback_builder.dart';

class DistanceRangeChecker {
  FeedbackBuilder feedbackBuilder = FeedbackBuilder();

  String rangeKneeShoulder(double distance) {
    if (distance > 0.55 && distance < 0.9) {
      return feedbackBuilder.feedBackBuilder("Joelho na posição correta");
    }
    return feedbackBuilder.feedBackBuilder("Joelho fora da posição correta");
  }

  String rangeElbowShoulder(double distance) {
    if (distance > 0.55 && distance < 0.9) {
      return feedbackBuilder.feedBackBuilder("Cotovelo na posição correta");
    }
    return feedbackBuilder.feedBackBuilder("Cotovelo fora da posição correta");
  }
}
