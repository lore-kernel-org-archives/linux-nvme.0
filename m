From: jack@suse.cz (Jan Kara)
Date: Thu, 24 Jan 2019 09:35:36 +0100
Subject: [PATCH 2/4] introduce four macros for in-kernel hints
In-Reply-To: <B4980620-2CFF-41C1-8EE7-C33F1FE431C0@javigon.com>
References: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
 <CGME20190109153336epcas2p29b3275b6c545e483a3f43b92268f08bf@epcas2p2.samsung.com>
 <1547047861-7271-3-git-send-email-joshi.k@samsung.com>
 <B4980620-2CFF-41C1-8EE7-C33F1FE431C0@javigon.com>
Message-ID: <20190124083536.GB12184@quack2.suse.cz>

On Wed 23-01-19 19:27:12, Javier Gonz?lez wrote:
> 
> > On 9 Jan 2019,@16.30, Kanchan Joshi <joshi.k@samsung.com> wrote:
> > 
> > Exiting write-hints are exposed to user-mode. There is a possiblity
> > of conflict if kernel happens to use those. This patch introduces four
> > write-hints for exclusive kernel-mode use.
> > 
> > Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
> > ---
> > include/linux/fs.h | 5 +++++
> > 1 file changed, 5 insertions(+)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 811c777..e8548eb 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -291,6 +291,11 @@ enum rw_hint {
> > 	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
> > 	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
> > 	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
> > +/* below ones are meant for in-kernel use */
> > +	KERN_WRITE_LIFE_SHORT,
> > +	KERN_WRITE_LIFE_MEDIUM,
> > +	KERN_WRITE_LIFE_LONG,
> > +	KERN_WRITE_LIFE_EXTREME
> > };
> > 
> 
> I think Jens and Dave meant kernel hints to go top down. This would also
> give space for supporting more hints / streams from both ends for user
> and kernel.

Yes, that was the idea however if I understand it right, the write hints do
not really have to be consistent boot-to-boot since they aren't stored
persistently by the disk, are they? If that's the case, it doesn't really
matter which numbers we pick.

One thing I don't quite like is the naming of KERN_WRITE_LIFE_SHORT etc.. It
is upto filesystem to assign meanings to the write hints. So I think it is
enough to provide something like KERN_WRITE_HINT_MIN which is the first
hint available to the kernel and then the number of hints available to the
kernel.

								Honza

-- 
Jan Kara <jack at suse.com>
SUSE Labs, CR
