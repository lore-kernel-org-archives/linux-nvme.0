From: davem@davemloft.net (David Miller)
Date: Tue, 27 Oct 2015 18:00:11 -0700 (PDT)
Subject: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
In-Reply-To: <CAGRGNgVvvcjHFjU4H1wnj6bGy69X19d-xR9O+Xc-p-TmtPxNgQ@mail.gmail.com>
References: <CAGRGNgXV+RJvjOBe351HyguYkonQ8F=CM3uZTijcqoQg6ArAcw@mail.gmail.com>
 <20151027234018.GA48779@linux.vnet.ibm.com>
 <CAGRGNgVvvcjHFjU4H1wnj6bGy69X19d-xR9O+Xc-p-TmtPxNgQ@mail.gmail.com>
Message-ID: <20151027.180011.1597667162481700758.davem@davemloft.net>

From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 28 Oct 2015 10:43:35 +1100

> You'll be CCing the maintainers of each architecture on the patches to
> add the functions, so if they do have specific requirements, I'm sure
> they'll let you know or provide patches.

People miss things, maintainers get busy, so while a CC: is important
and appreciated, it doesn't ensure a correct implementation is likely
to result.

Personally, I'd much rather my arch stop building so I have to go in
there to explicitly look at the reason why and make sure I fill in the
missing pieces properly and accurately.
