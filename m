From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 6 Sep 2015 10:46:35 +0300
Subject: [PATCH 3/4] block: Refuse adding appending a gaped integrity page
 to a bio
In-Reply-To: <yq1a8t2amtj.fsf@sermon.lab.mkp.net>
References: <1441297703-10753-1-git-send-email-sagig@mellanox.com>
 <1441297703-10753-4-git-send-email-sagig@mellanox.com>
 <yq1a8t2amtj.fsf@sermon.lab.mkp.net>
Message-ID: <55EBEF5B.3030608@dev.mellanox.co.il>

On 9/4/2015 6:24 AM, Martin K. Petersen wrote:
>>>>>> "Sagi" == Sagi Grimberg <sagig at mellanox.com> writes:
>
> Sagi> This is only theoretical at the moment given that the only
> Sagi> subsystems that generate integrity payloads are the block layer
> Sagi> itself and the scsi target (which generate well aligned integrity
> Sagi> payloads). But when we will expose integrity meta-data to
> Sagi> user-space, we'll need to refuse appending a page with a gap (if
> Sagi> the queue virtual boundary is set).
>

Hi Martin,

> Code looks fine but my concerns outlined in:
>
> http://lists.infradead.org/pipermail/linux-nvme/2015-July/002063.html

So given that this is a bug fix (was completely not handled before) I
think we should make an incremental progress towards getting it right.
Are you fine with that?

Now, given that drivers which set virt_boundary won't be able to accept
8-byte sg elements for DIX, would you prefer it being bounced rather
than refusing the merge? This would require some additional logic given
that we won't want to bounce on every merge attempt but only when the
request is kicked?

Sagi.
