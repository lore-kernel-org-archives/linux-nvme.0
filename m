From: axboe@fb.com (Jens Axboe)
Date: Fri, 17 Feb 2017 12:42:10 -0700
Subject: OPAL fixups
In-Reply-To: <20170217125941.14319-1-hch@lst.de>
References: <20170217125941.14319-1-hch@lst.de>
Message-ID: <b8891d4f-4ecf-4646-1e9b-e82009a17dc5@fb.com>

On 02/17/2017 05:59 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this contains a few more OPAL-related fixups.  It tones down warnings a bit,
> allocates the OPAL-?pecific data structure in a separate dynamic allocation,
> checks for support of Security Send/Receive in NVMe before using them,
> and makes sure we re-discovery the security capabilities after each reset.

Applied 1-3, thanks.

-- 
Jens Axboe
