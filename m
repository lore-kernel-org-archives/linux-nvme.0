From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 20 Sep 2017 14:31:00 -0700
Subject: [PATCH] nvme_fc: retry initial controller connections 3 times
In-Reply-To: <20170919231608.5575-1-jsmart2021@gmail.com>
References: <20170919231608.5575-1-jsmart2021@gmail.com>
Message-ID: <20170920213100.GA10442@infradead.org>

On Tue, Sep 19, 2017@04:16:08PM -0700, James Smart wrote:
> Currently, if a frame is lost of command fails as part of initial
> association create for a new controller, the new controller connection
> request will immediately fail.
> 
> Add in an immediate 3 retry loop before giving up.

How do we end up with the magic 3 value?
