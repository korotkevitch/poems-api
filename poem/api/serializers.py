from rest_framework import serializers
from poem.models import Poem, Review, Holiday, Author


class HolidaySerializer(serializers.ModelSerializer):

    class Meta:
        model = Holiday
        fields = "__all__"


class AuthorSerializer(serializers.ModelSerializer):

    class Meta:
        model = Author
        fields = "__all__"


class PoemSerializer(serializers.ModelSerializer):
    user = serializers.HiddenField(default=serializers.CurrentUserDefault())

    class Meta:
        model = Poem
        fields = "__all__"


class ReviewSerializer(serializers.ModelSerializer):
    review_user = serializers.StringRelatedField(read_only=True)

    class Meta:
        model = Review
        exclude = ('poem',)
        # fields = "__all__"