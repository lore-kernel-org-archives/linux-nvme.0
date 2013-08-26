From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 Aug 2013 09:01:21 -0600 (MDT)
Subject: Best way to exercise NVME ioctls
In-Reply-To: <CAFEQX0f1Wm_gxyXws-L3LzGP0-WE1SSr-aVCvYtxsU=umSXovA@mail.gmail.com>
References: <CAFEQX0f1Wm_gxyXws-L3LzGP0-WE1SSr-aVCvYtxsU=umSXovA@mail.gmail.com>
Message-ID: <alpine.LRH.2.03.1308260900500.1857@AMR>

On Sun, 25 Aug 2013, Prasad Joshi wrote:

> Hi All,
>
> I am doing experiments with nvme linux driver. I would like to write
> some sample programs which uses nvme ioctls. Specifically I wanted to
> invoke identify command to start with. nvme.h header file contains two
> structures "nvme_admin_cmd" and "nvme_identify", both seem to be
> identical.

I put some basic user programs up on another repository at

http://git.infradead.org/users/kbusch/nvme-user.git

It is very basic stuff; the programs there just run an nvme command
through the ioctl and print the data in more-or-less human readable
form.
