From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 26 Oct 2017 23:11:27 -0700
Subject: [PATCH 0/3] centralize transport not ready request check
In-Reply-To: <1508847922-26699-1-git-send-email-sagi@grimberg.me>
References: <1508847922-26699-1-git-send-email-sagi@grimberg.me>
Message-ID: <20171027061127.GA30853@infradead.org>

I like this a lot, but the big question is how we get this in as
we have a 4.14 change in this area.  Either we'll have a self-conflict
for 4.15, or we jus tdelay this to be pulled into 4.15 just after
-rc1?
