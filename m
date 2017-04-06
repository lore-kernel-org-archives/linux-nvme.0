From: hch@lst.de (Christoph Hellwig)
Date: Thu,  6 Apr 2017 17:39:19 +0200
Subject: kill req->errors
Message-ID: <20170406153944.10058-1-hch@lst.de>

Currently the request structure has an errors field that is used in
various different ways.  The oldest drivers use it as an error count,
blk-mq and the generic timeout code assume that it holds a Linux
errno for block completions, and various drivers use it for internal
status values, often overwriting them with Linux errnos later,
that is unless they are processing passthrough requests in which
case they'll leave their errors in it.

This series kills the ->errors field and replaced it with new fields
in the drivers (or an odd hack in a union in struct request for
two bitrotting old drivers).

Note that this series expects that the patch to remove the mg_disk
driver has been applied already on top of the block for-next tree.
