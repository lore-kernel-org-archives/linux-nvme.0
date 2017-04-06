From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Apr 2017 10:44:44 +0200
Subject: [PATCH for-4.11-rc 0/3] Fix wrong sqsize settings in fabrics
In-Reply-To: <1491459352-28200-1-git-send-email-sagi@grimberg.me>
References: <1491459352-28200-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170406084444.GA508@lst.de>

All the fixes looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>

But this duplicate code really screams for factoring it into helper..
