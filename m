From: osandov@osandov.com (Omar Sandoval)
Date: Mon, 14 May 2018 13:07:31 -0700
Subject: [PATCH] blktests: use global configfs variable
In-Reply-To: <20180508054532.13712-1-chaitanya.kulkarni@wdc.com>
References: <20180508054532.13712-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180514200731.GB13417@vader>

On Tue, May 08, 2018@01:45:32AM -0400, Chaitanya Kulkarni wrote:
> This patch introduces a global variable to hold the
> configfs nvmet path. Now we don't need repetitive
> local variables to hold the path and testcases
> can use the newly introduced variable if needed.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

Thanks, Chaitanya, that's a good cleanup. Applied.
