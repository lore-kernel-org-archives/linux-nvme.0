From: lwalkera@ieee.org (Laine Walker-Avina)
Date: Tue, 27 Nov 2012 09:47:48 -0800
Subject: Alignment Issue with Direct IO to NVMe Drive
In-Reply-To: <20121127170509.GA5100@linux.intel.com>
References: <CAMi7pMamJK079wQs+5Kaz=zdYGAPS+BFg2xCRKJMqPFMrQvQPQ@mail.gmail.com>
 <50B4AD8A.7020208@kernel.dk>
 <20121127170509.GA5100@linux.intel.com>
Message-ID: <CAMi7pMb7Ln02hLfa_i-7ucWZBDGzQLUOoQTeFp70=yGix_gojA@mail.gmail.com>

On Tue, Nov 27, 2012@9:05 AM, Matthew Wilcox <willy@linux.intel.com> wrote:
> Laine, when this occurs, what is the alignment of 'offset' in the sg
> entry you're looking at?  If userspace is passing in an unaligned address,
> I don't think there's anything we do to try to align it.

I thought this was the case as well, but it appears to be aligned
looking at the request in the user space program (fio using libaio in
this case) before the IO is submitted.

Laine
