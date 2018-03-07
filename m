From: sitsofe@gmail.com (Sitsofe Wheeler)
Date: Wed, 7 Mar 2018 17:47:34 +0000
Subject: [PATCH] Revert "nvme: create 'slaves' and 'holders' entries for
 hidden controllers"
In-Reply-To: <20180307173842.GA3766@localhost.localdomain>
References: <20180307131358.20275-1-hch@lst.de>
 <1c1332d4-1d92-af8f-974c-2eafcde741f2@suse.de>
 <20180307150344.GE30975@localhost.localdomain>
 <CALjAwxgLXdk1hhmtb3Dp2=U_o1E-MqObBxUroAj+sJU2uNHx4g@mail.gmail.com>
 <20180307171805.GA810@lst.de> <20180307173842.GA3766@localhost.localdomain>
Message-ID: <CALjAwxgic8ACMRW_56W+BVnikUK+FzNmp-UMJ3qNYmxPZ3idsg@mail.gmail.com>

On 7 March 2018@17:38, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, Mar 07, 2018@06:18:05PM +0100, Christoph Hellwig wrote:
>>
>> Yes, I think we should simply creates a paths/ directory.  Not sure
>> there is much point in the backlink.
>
> That sounds good to me. For now, looks like we need the revert for the
> current rc and stable; applied to nvme-4.16-rc5.

The only thing that concerns me is where do the stats live? Over in
https://github.com/axboe/fio/pull/526#issuecomment-369521772 we found
the main device doesn't record stats. Will that still be the case?

-- 
Sitsofe | http://sucs.org/~sits/
