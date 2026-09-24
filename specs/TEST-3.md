# Spec: sample menu endpoint

## Summary
Expose a small demo menu endpoint so the UI has a simple static JSON payload to
render.

## Actors
- Demo user
- UI developer

## Acceptance criteria
- Given the app is running, When a client `GET`s `/api/menu`,
  Then the response is `200` with a JSON body containing a static list of a few
  sample menu items.
- Given the endpoint is intended for demos, When `/api/menu` is called multiple
  times without code or config changes,
  Then it returns the same sample items in the same JSON structure.
- Given the UI needs something simple to render, When the response is returned,
  Then each sample item includes stable display data suitable for a basic menu
  view.

## Out of scope
- Backing the menu with a database or other dynamic data source.
- Create/update/delete menu management.
- Filtering, search, or personalization.

## Open questions
- What exact fields should each sample menu item include for the demo UI?
