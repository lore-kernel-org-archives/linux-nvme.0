From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 9 Oct 2015 00:36:15 -0700
Subject: [PATCH 5/5] block: Inline blk_integrity in struct gendisk
In-Reply-To: <20150921204506.GA36289@redhat.com>
References: <20150721120102.GB1654@infradead.org>
 <1440103314-31610-1-git-send-email-martin.petersen@oracle.com>
 <1440103314-31610-6-git-send-email-martin.petersen@oracle.com>
 <20150916010720.GA21398@redhat.com>
 <20150921204506.GA36289@redhat.com>
Message-ID: <20151009073615.GA9144@infradead.org>

On Mon, Sep 21, 2015@04:45:07PM -0400, Mike Snitzer wrote:
> Here is what I came up with.  Leaves something to be desired given the
> integrity profile is being established on first table load (as opposed
> to during resume like the old DM and block integrity code did).. but we
> can iterate on this as needed.
> 
> Feel free to fold it into your last patch and add my Signed-off-by.

Martin, any chance to repost with Mike's changes folded in?  I'd really
hate to miss 4.4 for the series.
