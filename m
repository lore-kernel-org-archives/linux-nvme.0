From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 14 Oct 2015 09:50:31 -0700
Subject: [PATCH v6 05/11] block: remove split code in
 blkdev_issue_{discard,write_same}B
In-Reply-To: <alpine.LNX.2.00.1510141620500.27742@localhost.lm.intel.com>
References: <1439363241-31772-1-git-send-email-mlin@kernel.org>
 <1439363241-31772-6-git-send-email-mlin@kernel.org>
 <20151013115011.GA6546@infradead.org>
 <CAF1ivSbsH7JsduHE+a2d+BEbZL6Fo7uJWS2NCTTMNTSAUMt0UA@mail.gmail.com>
 <20151014132700.GA19401@infradead.org>
 <alpine.LNX.2.00.1510141620500.27742@localhost.lm.intel.com>
Message-ID: <20151014165031.GA32274@infradead.org>

On Wed, Oct 14, 2015@04:38:50PM +0000, Keith Busch wrote:
> I see why the proposal is an improvement, but I don't understand why the
> current situation results in a hang. Are we missing some kind of error
> recovery in the driver?

The driver tries to abort the commands and eventually gets into a death
spiral.  I'm still trying to understand what exactly is going on.
