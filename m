From: hch@lst.de (Christoph Hellwig)
Date: Mon, 30 Jul 2018 11:04:45 +0200
Subject: [PATCH V2 1/2] nvme-cli: add minimal ana-log page support
In-Reply-To: <ef81592a-6c94-aef0-9405-95a5de9ad050@suse.de>
References: <20180726041842.9668-1-chaitanya.kulkarni@wdc.com>
 <20180726041842.9668-2-chaitanya.kulkarni@wdc.com>
 <ef81592a-6c94-aef0-9405-95a5de9ad050@suse.de>
Message-ID: <20180730090445.GA18309@lst.de>

On Mon, Jul 30, 2018@09:43:19AM +0200, Hannes Reinecke wrote:
> This is wrong; 'mnan' is a 32-bit integer.
> (Hence the next field is called 'rsvd544', as it starts at offset 544...)

As a rule of thumb please always add fields in the kernel nvme.h
and then sync it over to nvme-cli.

I guess we need to document that somewhere in nvme-cli..
