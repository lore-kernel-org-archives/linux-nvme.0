From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 30 Sep 2015 05:59:42 +0800
Subject: [PATCH 0/3] blk-mq & nvme: introduce .map_changed
In-Reply-To: <20150929070722.GA15110@lst.de>
References: <1443496857-26887-1-git-send-email-tom.leiming@gmail.com>
 <20150929070722.GA15110@lst.de>
Message-ID: <CACVXFVP92ua+30AW_n7nDCH9rJjQgVENpiswxtTpU5QekbDNbQ@mail.gmail.com>

On Tue, Sep 29, 2015@3:07 PM, Christoph Hellwig <hch@lst.de> wrote:
> Hi Ming,
>
> from a quick gance this looks very useful.  Please split the callback
> into two instead of overloading them with the bool mapped parameter.

The mapped parameter can be removed since it can be figured out by
checking 'hctx->tags'.

IMO, it isn't good to split it into two callback, such as,
map_activate/map_deactivate or other names, and the two callback
can't be symmetrical at all.  When CPU hotplug happened, it is just
the mapping changed, neigher setuping nor tearing down since it is
1:N mapping between hw queue and percpu sw queue.

So I suggest to keep it as .map_changed(), or do you have better idea?

>
> Please keep Akinobu Mita in the loop, as this should go on top of his blk-mq
> fixes.

OK.

-- 
Ming Lei
