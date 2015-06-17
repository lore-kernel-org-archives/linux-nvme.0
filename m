From: m@bjorling.me (Matias Bjorling)
Date: Wed, 17 Jun 2015 20:04:07 +0200
Subject: [PATCH v4 0/8] Support for Open-Channel SSDs
In-Reply-To: <20150617135905.GA17119@infradead.org>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
 <20150609074643.GA5707@infradead.org> <55787DDE.7020801@bjorling.me>
 <20150611102935.GA4419@infradead.org> <557C5787.3000608@bjorling.me>
 <20150617135905.GA17119@infradead.org>
Message-ID: <5581B697.2060800@bjorling.me>

> I don't think the current abuses of the block API are acceptable though.
> The crazy deep merging shouldn't be too relevant for SSD-type devices
> so I think you'd do better than trying to reuse the TYPE_FS level
> blk-mq merging code.  If you want to reuse the request
> allocation/submission code that's still doable.
>
> As a start add a new submit_io method to the nvm_dev_ops, and add
> an implementation similar to pscsi_execute_cmd in
> drivers/target/target_core_pscsi.c for nvme, and a trivial no op
> for a null-nvm driver replacing the null-blk additions.  This
> will give you very similar behavior to your current code, while
> allowing to drop all the hacks in the block code.  Note that simple
> plugging will work just fine which should be all you'll need.
>

Thanks, I appreciate you taking the time to go through it. I'll respin 
the patches and remove the block hacks.
