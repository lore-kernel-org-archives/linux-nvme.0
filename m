From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 21 Oct 2015 00:21:26 -0700
Subject: [PATCH v6 05/11] block: remove split code in
 blkdev_issue_{discard,write_same}
In-Reply-To: <CAF1ivSbsH7JsduHE+a2d+BEbZL6Fo7uJWS2NCTTMNTSAUMt0UA@mail.gmail.com>
References: <1439363241-31772-1-git-send-email-mlin@kernel.org>
 <1439363241-31772-6-git-send-email-mlin@kernel.org>
 <20151013115011.GA6546@infradead.org>
 <CAF1ivSbsH7JsduHE+a2d+BEbZL6Fo7uJWS2NCTTMNTSAUMt0UA@mail.gmail.com>
Message-ID: <20151021072126.GA7671@infradead.org>

Jens, Ming:

are you fine with the one liner change to get back to the old I/O
pattern?  While it looks like the cards fault I'd like to avoid this
annoying regression.
