From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 21 Dec 2017 20:31:57 +0200
Subject: [PATCH 4.15-rc 3/3] nvme-fabrics: Protect against module unload
 during create_ctrl
In-Reply-To: <20171221102536.GB11259@infradead.org>
References: <20171221100752.18386-1-sagi@grimberg.me>
 <20171221100752.18386-4-sagi@grimberg.me>
 <20171221102536.GB11259@infradead.org>
Message-ID: <3405b398-abb1-3a84-215b-769fbaf79891@grimberg.me>

> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Meh, its missing a ref put.. lets hold off on it for now.
