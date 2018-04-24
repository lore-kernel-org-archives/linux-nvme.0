From: hch@lst.de (Christoph Hellwig)
Date: Tue, 24 Apr 2018 19:30:11 +0200
Subject: [PATCH 06/20] nvmet: add new members for sync file I/O
In-Reply-To: <20180418190011.3973-7-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
 <20180418190011.3973-7-chaitanya.kulkarni@wdc.com>
Message-ID: <20180424173011.GD30391@lst.de>

On Wed, Apr 18, 2018@02:59:57PM -0400, Chaitanya Kulkarni wrote:
> This patch adds new structure members to implement O_SYNC
> IO mode for file-backed ns. The user can optionally choose
> to switch between O_SYNC and O_DIRECT with the configfs parameter
> which we add in the next patch.

Again please introduce the fields together with code using them.

O_SYNC and O_DIRECT can combined, which makes the description above
sounds rather strange.
