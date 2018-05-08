From: hare@suse.de (Hannes Reinecke)
Date: Tue, 8 May 2018 08:00:41 +0200
Subject: [PATCH 3/7] nvme_fc: retry failures to set io queue count
In-Reply-To: <20180508001214.8951-4-jsmart2021@gmail.com>
References: <20180508001214.8951-1-jsmart2021@gmail.com>
 <20180508001214.8951-4-jsmart2021@gmail.com>
Message-ID: <20180508080041.62af2693@pentland.suse.de>

On Mon,  7 May 2018 17:12:10 -0700
"James Smart" <jsmart2021@gmail.com> wrote:

> During the creation of a new controller association, it's possible for
> errors and link connectivity issues to cause nvme_set_queue_count() to
> have its SET_FEATURES command fail with a positive non-zero code. The
> routine doesn't treat this as a hard error, instead setting the io
> queue count to zero and returning success.  This has the result of the
> transport setting the io queue count to 0, making the storage
> controller inoperable. The message "...Could not set queue count..."
> is seen.
> 
> Revise the fc transport to detect when it asked for io queues but got
> back a result of 0 io queues. In such a case, fail the re-connection
> attempt and fall into the retry loop.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/host/fc.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
The usual problem when having _two_ return values.
Can't have nvme_set_queue_count() return the number of queues or a
negative number on failure?
Then the check would be much simplified.

Cheers,

Hannes
