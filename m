From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 22 Oct 2015 03:24:44 -0700
Subject: [PATCH v6 05/11] block: remove split code in
 blkdev_issue_{discard,write_same}
In-Reply-To: <1445458389.26847.10.camel@ssi>
References: <1439363241-31772-1-git-send-email-mlin@kernel.org>
 <1439363241-31772-6-git-send-email-mlin@kernel.org>
 <20151013115011.GA6546@infradead.org>
 <CAF1ivSbsH7JsduHE+a2d+BEbZL6Fo7uJWS2NCTTMNTSAUMt0UA@mail.gmail.com>
 <20151014132700.GA19401@infradead.org>
 <20151021160232.GA5089@redhat.com>
 <20151021161947.GA5212@redhat.com> <1445448806.26847.6.camel@ssi>
 <20151021181812.GA5807@redhat.com> <1445458389.26847.10.camel@ssi>
Message-ID: <20151022102444.GA13610@infradead.org>

On Wed, Oct 21, 2015@01:13:09PM -0700, Ming Lin wrote:
> How about below?
> It actually reverts commit b49a0871 and adds patch at
> https://www.redhat.com/archives/dm-devel/2015-August/msg00000.html
> 
> Christoph, could you help to try it?

Still causes hickups with my controller unfortunately.
