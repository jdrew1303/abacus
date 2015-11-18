# Abacus

https://github.com/neilgupta/abacus

## Usage

1. Create an account on Abacus

2. Add your app to Abacus to get your API keys and modify your event settings

3. Add to your web app

```html
<script type="text/javascript" src="//localhost:5000/abacus.js"></script>

<script type="text/javascript">
  abacus.apiKey('your-api-key');
</script>
```

4. Add to your video pages

```javascript
  abacus.register(video, mediaId, userId);
```

## How It Works

### Abacus.js

`Abacus.js` automatically registers to the following video events and reports them back to Abacus via websockets:

  - play
  - pause
  - seeked
  - volumechange
  - timeupdate

### Admins, Apps, EventTypes

A user can manage multiple apps. Each app has its own set of events it can track. By default, Abacus will create the following events for an app (they can be removed/edited):

  - play
  - pause
  - comment
  - volumechange
  - like
  - unlike

### Media

All media that is being tracked with Abacus must be registered with a media_id, duration, and optional url. Abacus needs the media duration for accurate analysis of the play/pause data.

### Events, PlaySegments

When an event comes in, Abacus analyzes it for relevant metadata. Each event is weighted so that we can determine a score for the video's performance and for each user's performance.

For example, when a user posts a comment, Abacus uses (basic) sentiment analysis to determine whether the comment is positive or negative and weights it accordingly.

When a video is paused, Abacus finds its corresponding play event and creates a `PlaySegment`, which allows us to see what segments of a video are being watched and re-watched.

## What's Done and What's Left

Abacus.js and the API for saving data exists, but is untested.

TODO:

- API for retrieving data
- CAS integration
- UI for managing data
- specs
