From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Thu, 7 Sep 2017 14:59:14 +0000
Subject: [PATCH 1/3] block: introduce blk_mq_tagset_iter
In-Reply-To: <1504711832-28425-2-git-send-email-sagi@grimberg.me>
References: <1504711832-28425-1-git-send-email-sagi@grimberg.me>
 <1504711832-28425-2-git-send-email-sagi@grimberg.me>
Message-ID: <1504796352.2646.2.camel@wdc.com>

On Wed, 2017-09-06@18:30 +0300, Sagi Grimberg wrote:
> Iterator helper to apply a function on all the
> tags in a given tagset. export it as it will be used
> outside the block layer later on.

Thanks Sagi for having done this work.

Reviewed-by: Bart Van Assche <bart.vanassche at wdc.com>
