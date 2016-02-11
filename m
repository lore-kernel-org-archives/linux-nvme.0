From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 11 Feb 2016 14:29:59 +0200
Subject: [PATCH for-4.5 13/13] NVMe: Rate limit nvme IO warnings
In-Reply-To: <20160210211025.GC23402@localhost.localdomain>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-14-git-send-email-keith.busch@intel.com>
 <20160210185404.GB10459@infradead.org>
 <20160210211025.GC23402@localhost.localdomain>
Message-ID: <56BC7EC7.6020208@dev.mellanox.co.il>


>> Do we need this message at all?
>
> I don't find it useful for anything other than confirming a test hit
> that path. Delete it?

Perhaps we can have it dev_dbg.
