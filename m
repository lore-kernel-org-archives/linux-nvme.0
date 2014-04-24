From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 Apr 2014 12:57:07 -0600 (MDT)
Subject: NVMe Controllers capability doubt
In-Reply-To: <CAMjVwgR2KABZ_ecLqa-NR+aFGF_yRJk=uFLkZzOm+a9+u0Q5TA@mail.gmail.com>
References: <CAMjVwgR2KABZ_ecLqa-NR+aFGF_yRJk=uFLkZzOm+a9+u0Q5TA@mail.gmail.com>
Message-ID: <alpine.LRH.2.03.1404241249280.5490@AMR>

On Thu, 24 Apr 2014, Angelo Brito wrote:
> I was asked if a NVMe controller must support end user's or driver
> developer's custom commands. I always understood that Commands beyond
> specification can be added by the vendor if he decides to. But a
> costumer told us that he interpreted from specs that the controller
> must also support commands added by the end user. What are yours
> toughs about this?

How on earth would an NVMe controller be able to anticipate what custom
commands an end user might make up? No, vendor unique commands are
implemented by the vendor, not the end-user. The same opcode might even
be completely different commands for two different devices.
