From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 11 Jun 2018 16:16:16 +0200
Subject: [PATCH] nvmet: free smart-log buffer after use
In-Reply-To: <20180611072024.485-1-chaitanya.kulkarni@wdc.com>
References: <20180611072024.485-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180611141616.duumxa22c7y7qvqr@infradead.org>

On Mon, Jun 11, 2018@03:20:24AM -0400, Chaitanya Kulkarni wrote:
> Free smart-log buffer allocated in the function after use.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

Thanks, applied with a small tweak.
