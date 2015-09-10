From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 10 Sep 2015 12:10:36 +0300
Subject: [PATCH 3/4] block: Refuse adding appending a gaped integrity page
 to a bio
In-Reply-To: <yq137yo6a78.fsf@sermon.lab.mkp.net>
References: <1441297703-10753-1-git-send-email-sagig@mellanox.com>
 <1441297703-10753-4-git-send-email-sagig@mellanox.com>
 <yq1a8t2amtj.fsf@sermon.lab.mkp.net> <55EBEF5B.3030608@dev.mellanox.co.il>
 <yq137yo6a78.fsf@sermon.lab.mkp.net>
Message-ID: <55F1490C.7050105@dev.mellanox.co.il>

On 9/8/2015 9:24 PM, Martin K. Petersen wrote:
>>>>>> "Sagi" == Sagi Grimberg <sagig at dev.mellanox.co.il> writes:
>
> Sagi,
>
> Sagi> So given that this is a bug fix (was completely not handled
> Sagi> before) I think we should make an incremental progress towards
> Sagi> getting it right.  Are you fine with that?
>
> Yeah, I don't have an objection to your changes.
>
> Sagi> Now, given that drivers which set virt_boundary won't be able to
> Sagi> accept 8-byte sg elements for DIX, would you prefer it being
> Sagi> bounced rather than refusing the merge? This would require some
> Sagi> additional logic given that we won't want to bounce on every merge
> Sagi> attempt but only when the request is kicked?
>
> For some workloads I think bouncing is inevitable by virtue of the PI
> payload being teeny tiny by design.

I see. I guess we can bounce DIX data, but is it always "right" to
bounce? I don't know, as you say, it is workload dependent.
