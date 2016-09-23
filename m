From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:33:01 -0700
Subject: [PATCH RFC] nvme-cli: propose 'c' vs 'r' for connect flag
In-Reply-To: <1474583840-23739-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1474583840-23739-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <20160923033301.GB12637@infradead.org>

On Thu, Sep 22, 2016@03:37:20PM -0700, Jay Freyensee wrote:
> I am not sure if it matters too much except in possibly
> human usage understanding, but '-r' is used in the 'discover'
> command for --raw.  Change the --reconnect-delay flag
> single letter to something not being used in any fabrics
> command.

Sounds ok to me.  But I have to say dealing with these short options
start to be a little annoying.  For a lot of these commands I'd prefer
to simply support long options only if we could (I'll need to look
at argconfig.c in a bit more detail how easily that could be done).
