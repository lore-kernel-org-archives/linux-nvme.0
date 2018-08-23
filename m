From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 23 Aug 2018 02:34:43 +0000
Subject: [PATCH V2] nvmet: free workqueue object if module init fails
In-Reply-To: <20180822130531.GB8963@infradead.org>
References: <20180816014825.13762-1-chaitanya.kulkarni@wdc.com>
 <20180822130531.GB8963@infradead.org>
Message-ID: <94047CDA-34FD-463D-AB47-2F03AB74B981@wdc.com>

Thanks Christoph, everything looks good.

On 8/22/18, 6:05 AM, "Christoph Hellwig" <hch@infradead.org> wrote:

    Looks good, but I had to apply this manually as the context didn't
    match what is upstream.  Please double check that I didn't mess
    it up.
    
