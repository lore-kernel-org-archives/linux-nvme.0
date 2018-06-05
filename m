From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 5 Jun 2018 10:20:53 -0600
Subject: Bug report: critical medium error during 8k local nvme write
In-Reply-To: <93935ee4-52eb-a514-1b46-21c0f3b6e31d@mellanox.com>
References: <93935ee4-52eb-a514-1b46-21c0f3b6e31d@mellanox.com>
Message-ID: <20180605162053.GC16899@localhost.localdomain>

On Tue, May 29, 2018@04:08:08PM +0300, Max Gurtovoy wrote:
> hi Keith,
> I want to report on a bug I've seen in my local nvme drive configured to run
> with metadata format using:

I think you got this one fixed in your patch "nvme: Fix extended data
LBA supported setting".
