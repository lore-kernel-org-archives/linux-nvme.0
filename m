From: hch@lst.de (Christoph Hellwig)
Date: Sun, 24 Sep 2017 15:04:46 +0200
Subject: [PATCH rfc] nvme-fabrics: request transport module
In-Reply-To: <74246ccf-53e3-7956-3117-16e44f2f8793@grimberg.me>
References: <1506257125-15257-1-git-send-email-sagi@grimberg.me>
 <20170924125507.GA11632@infradead.org>
 <74246ccf-53e3-7956-3117-16e44f2f8793@grimberg.me>
Message-ID: <20170924130446.GA7373@lst.de>

On Sun, Sep 24, 2017@04:03:55PM +0300, Sagi Grimberg wrote:
>> Also if I remember correctly request_module returns an error if the
>> driver is built-in, thus most callers either don't check the return
>> value or just print a warning (I personally hate the warning, so I think
>> we should just do the simple request_module call).
>
> So skip the return value altogether? I don't mind that...

Yes.
