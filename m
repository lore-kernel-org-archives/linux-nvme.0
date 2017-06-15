From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Jun 2017 19:44:00 +0300
Subject: [PATCH 1/2] nvme: use a single NVME_AQ_DEPTH
In-Reply-To: <20170615163627.GA31576@infradead.org>
References: <1497544496-25134-1-git-send-email-sagi@grimberg.me>
 <20170615163627.GA31576@infradead.org>
Message-ID: <2791261d-5398-88ac-c012-8a6bc3af7cf5@grimberg.me>


> Note that Fabrics controller are not required to support more than
> 32 AQ entries.  So we probably should just lower the value for everyone
> as there is no point in having more entries on PCIe either.

I'm down with that...

Keith? Any objections?
