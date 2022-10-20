from rest_framework import serializers
from poem.models import Poem


class PoemSerializer(serializers.ModelSerializer):
    user = serializers.HiddenField(default=serializers.CurrentUserDefault())

    class Meta:
        model = Poem
        fields = "__all__"