From: william.kucharski@oracle.com (William Kucharski)
Date: Tue, 30 Apr 2019 06:12:04 -0600
Subject: Read-only Mapping of Program Text using Large THP Pages
In-Reply-To: <CAPhsuW6uDeXrRU9pd-kPOzjJn3DVdx0O5Lny_hpyQ=Fpbhg4gw@mail.gmail.com>
References: <379F21DD-006F-4E33-9BD5-F81F9BA75C10@oracle.com>
 <20190220134454.GF12668@bombadil.infradead.org>
 <07B3B085-C844-4A13-96B1-3DB0F1AF26F5@oracle.com>
 <20190220144345.GG12668@bombadil.infradead.org>
 <20190220163921.GA4451@localhost.localdomain>
 <20190220171905.GJ12668@bombadil.infradead.org>
 <B53C9F2D-966C-4DFD-8151-0A7255ACA9AD@oracle.com>
 <CAPhsuW6uDeXrRU9pd-kPOzjJn3DVdx0O5Lny_hpyQ=Fpbhg4gw@mail.gmail.com>
Message-ID: <C39B5A6C-2898-44DC-B11B-017908261C09@oracle.com>



> On Apr 28, 2019,@2:08 PM, Song Liu <liu.song.a23@gmail.com> wrote:
> 
> We will bring this proposal up in THP discussions. Would you like to share more
> thoughts on pros and cons of the two solutions? Or in other words, do you have
> strong reasons to dislike either of them?

I think it's a performance issue that needs to be hashed out.

The obvious thing to do is read the whole large page and then map
it, but depending on the architecture or I/O speed, mapping one
PAGESIZE page to satisfy the single fault while the large page is
being read in could potentially be faster. However, as with all
swags without actual data who can say. You can also bring up the
question of whether with SSDs and NVME storage if it makes sense
to worry anymore about how long it would take to read a 2M or even
1G page in from storage. I like the idea of simply reading the
entire large page purely for neatness reasons - recovering from an
error during redhead of a large page seems like it could become
rather complex.

One other issue is how this will interact with filesystems and how
and how to tell filesystems I want a large page's worth of data.
Matthew mentioned that compound_order() can be used to detect the
page size, so that's one answer, but obviously no such code exists
as of yet and it would need to be propagated across all file systems.

I really hope the discussions at LSFMM are productive.

-- Bill
