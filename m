From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 21 Oct 2015 12:33:07 -0400
Subject: [PATCH v6 05/11] block: remove split code in
 blkdev_issue_{discard, write_same}
In-Reply-To: <20151021161947.GA5212@redhat.com> (Mike Snitzer's message of
 "Wed, 21 Oct 2015 12:19:47 -0400")
References: <1439363241-31772-1-git-send-email-mlin@kernel.org>
 <1439363241-31772-6-git-send-email-mlin@kernel.org>
 <20151013115011.GA6546@infradead.org>
 <CAF1ivSbsH7JsduHE+a2d+BEbZL6Fo7uJWS2NCTTMNTSAUMt0UA@mail.gmail.com>
 <20151014132700.GA19401@infradead.org>
 <20151021160232.GA5089@redhat.com> <20151021161947.GA5212@redhat.com>
Message-ID: <yq1mvvcfags.fsf@sermon.lab.mkp.net>

>>>>> "Mike" == Mike Snitzer <snitzer at redhat.com> writes:

>> That should work for all devices and for dm-thinp (and dm-cache) in
>> particular will ensure that all discards that are issued will be a
>> multiple of the underlying device's blocksize.

Mike> Jeff Moyer pointed out having req_sects be a factor of
Mike> discard_granularity makes more sense.

Absolutely!

-- 
Martin K. Petersen	Oracle Linux Engineering
