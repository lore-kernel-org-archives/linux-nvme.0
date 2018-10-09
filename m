From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 9 Oct 2018 09:50:12 -0700
Subject: [PATCH] nvmet: remove unreachable code
In-Reply-To: <20180823025845.13150-1-chaitanya.kulkarni@wdc.com>
References: <20180823025845.13150-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181009165012.GA2126@infradead.org>

On Wed, Aug 22, 2018@07:58:45PM -0700, Chaitanya Kulkarni wrote:
> Get rid of the unreachable code in the nvmet_parse_discovery_cmd().
> Keep the error message identical to the admin-cmd.c and io-cmd*.c
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

Thanks,

applied to nvme-4.20.
