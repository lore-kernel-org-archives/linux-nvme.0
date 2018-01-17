From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 17 Jan 2018 21:58:35 +0900
Subject: [PATCH 1/2] nvme: pci: replace magic number with readable size
 macro in hmb code
In-Reply-To: <20180115020846.GD13580@localhost.localdomain>
References: <1515930040-20561-1-git-send-email-minwoo.im.dev@gmail.com>
 <20180115020846.GD13580@localhost.localdomain>
Message-ID: <CAA7jzteBx-nbOnFZV4Tprjd-bkbBNFA-6WaC1QZ73oUYfF8YYw@mail.gmail.com>

On Mon, Jan 15, 2018@11:08 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Sun, Jan 14, 2018@08:40:40PM +0900, Minwoo Im wrote:
>> Those three identify fields(hmpre, hmmin, hmminds) have size in 4KB
>> units.
>>
>> Replace magic numbers with human-readable size macro.
>>
>> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
>
> Looks fine, though I thought an explicit #include <linux/sizes.h> is
> in order since it's not obvious how we're pulling in these defines, but
> there's already other SZ_* macro uses in this file, so it must be safe!
>
> Reviewed-by: Keith Busch <keith.busch at intel.com>

Keith,

Thanks for your kind review.
I agree that explicit #include always seems right.
