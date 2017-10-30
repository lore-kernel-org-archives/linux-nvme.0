From: keith.busch@intel.com (Keith Busch)
Date: Mon, 30 Oct 2017 13:36:16 -0600
Subject: [PATCH] nvme-cli: fix wrong bitmask in number of rpmb units.
In-Reply-To: <1509213712-32675-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1509213712-32675-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <20171030193615.GH17245@localhost.localdomain>

On Sun, Oct 29, 2017@03:01:52AM +0900, Minwoo Im wrote:
> Number of RPMB Units is a 3-bit field[02:00].
> Bitmask should be 0111b(7h) to get this field.
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>

Applied, thanks.
