From: vishal.l.verma@intel.com (Verma, Vishal L)
Date: Thu, 19 Sep 2013 22:25:24 +0000
Subject: [PATCH 1/2] NVMe: Cocci spatch "kzalloc-simple"
In-Reply-To: <1379604510863-2133994021-1-diffsplit-thomas@m3y3r.de>
Message-ID: <CE60D5BF.F105%vishal.l.verma@intel.com>

On 9/19/13 3:45 PM, "Thomas Meyer" <thomas@m3y3r.de> wrote:

>Use kzalloc rather than kmalloc followed by memset with 0.
>Found by coccinelle spatch "api/alloc/kzalloc-simple.cocci"
>
>Signed-off-by: Thomas Meyer <thomas at m3y3r.de>
>---

Thomas,

This has already been applied to Matthew's tree:
http://git.infradead.org/users/willy/linux-nvme.git/commitdiff/03ea83e9a37e
41d436f8348e6eee3d8281bfff3a


-Vishal
