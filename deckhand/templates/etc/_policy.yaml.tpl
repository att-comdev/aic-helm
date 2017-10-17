# Copyright 2017 AT&T Intellectual Property.  All other rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Default rule for most Admin APIs.
"admin_api": "role:admin"

# Create a batch of documents specified in the request body, whereby
# a new revision is created. Also, roll back a revision to a previous
# one in the
# revision history, whereby the target revision's documents are re-
# created for
# the new revision.
# PUT  /api/v1.0/bucket/{bucket_name}/documents
# POST  /api/v1.0/rollback/{target_revision_id}
"deckhand:create_cleartext_documents": "rule:admin_api"

# Create a batch of documents specified in the request body, whereby
# a new revision is created. Also, roll back a revision to a previous
# one in the
# history, whereby the target revision's documents are re-created for
# the new
# revision.
#
# Only enforced after ``create_cleartext_documents`` passes.
#
# Conditionally enforced for the endpoints below if the any of the
# documents in
# the request body have a ``metadata.storagePolicy`` of "encrypted".
# PUT  /api/v1.0/bucket/{bucket_name}/documents
# POST  /api/v1.0/rollback/{target_revision_id}
"deckhand:create_encrypted_documents": "rule:admin_api"

# List cleartext documents for a revision (with no layering or
# substitution applied) as well as fully layered and substituted
# concrete
# documents.
# GET  api/v1.0/revisions/{revision_id}/documents
# GET  api/v1.0/revisions/{revision_id}/rendered-documents
"deckhand:list_cleartext_documents": "rule:admin_api"

# List encrypted documents for a revision (with no layering or
# substitution applied) as well as fully layered and substituted
# concrete
# documents.
#
# Only enforced after ``list_cleartext_documents`` passes.
#
# Conditionally enforced for the endpoints below if any of the
# documents in the
# request body have a ``metadata.storagePolicy`` of "encrypted". If
# policy
# enforcement fails, encrypted documents are exluded from the
# response.
# GET  api/v1.0/revisions/{revision_id}/documents
# GET  api/v1.0/revisions/{revision_id}/rendered-documents
"deckhand:list_encrypted_documents": "rule:admin_api"

# Show details for a revision.
# GET  /api/v1.0/revisions/{revision_id}
"deckhand:show_revision": "rule:admin_api"

# List all revisions.
# GET  /api/v1.0/revisions
"deckhand:list_revisions": "rule:admin_api"

# Delete all revisions. Warning: this is equivalent to purging the
# database.
# DELETE  /api/v1.0/revisions
"deckhand:delete_revisions": "rule:admin_api"

# Show revision diff between two revisions.
# GET  /api/v1.0/revisions/{revision_id}/diff/{comparison_revision_id}
"deckhand:show_revision_diff": "rule:admin_api"

# Create a revision tag.
# POST  /api/v1.0/revisions/{revision_id}/tags
"deckhand:create_tag": "rule:admin_api"

# Show details for a revision tag.
# GET  /api/v1.0/revisions/{revision_id}/tags/{tag}
"deckhand:show_tag": "rule:admin_api"

# List all tags for a revision.
# GET  /api/v1.0/revisions/{revision_id}/tags
"deckhand:list_tags": "rule:admin_api"

# Delete a revision tag.
# DELETE  /api/v1.0/revisions/{revision_id}/tags/{tag}
"deckhand:delete_tag": "rule:admin_api"

# Delete all tags for a revision.
# DELETE  /api/v1.0/revisions/{revision_id}/tags
"deckhand:delete_tags": "rule:admin_api"
