From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 22 Apr 2014 09:57:31 -0600
Subject: Wheather the NVMe driver has been tried on the IBM or Lenovo
 server?
In-Reply-To: <7174f4a8.23ad7.14589360cb2.Coremail.liaohengquan1986@163.com>
References: <1397000541-1085-1-git-send-email-keith.busch@intel.com>
 <1397000541-1085-2-git-send-email-keith.busch@intel.com>
 <CAP8+hKWcybw5u_m5M4c1p4eUAaTq4x+kO+tnegwD2ciDMEFNCw@mail.gmail.com>
 <alpine.LRH.2.03.1404211935510.5490@AMR>
 <1E05E2AB-198E-473A-8AA5-87DA2E9910B8@gmail.com>
 <CAP8+hKUEygoeEv=LvY2ccp6cepnXEpi4WGVSaCnRw+zN7BUE_Q@mail.gmail.com>
 <B8DB29EA17EB2742AC3405C31A9B9EE961457B96@ORSMSX111.amr.corp.intel.com>
 <CAP8+hKV_-OqAOWHC2tZqYmt1O9pjTtauXECU=R+48rb0A3EfQA@mail.gmail.com>
 <7174f4a8.23ad7.14589360cb2.Coremail.liaohengquan1986@163.com>
Message-ID: <CAErSpo526WATQKU9DZ4YjTTL9ot_1soGnjcs=ipgyqt2XNQ-fA@mail.gmail.com>

On Tue, Apr 22, 2014 at 5:33 AM, liaohengquan1986
<liaohengquan1986@163.com> wrote:
>
> Hi, everyone,
>             I want to ask that weather the NVMe driver has been tried on the
> IBM or Lenovo server?
>             I use it on IBM(Lenovo) server with suse 11 SP3, but the MSI-X
> irq is always could not be got by cpu(may be it is masked).
>             Has anyone got this kind of problem?

I think your original email contained non-plain text, so it won't
appear on the mailing list, and some recipients may auto-discard it as
well.  See http://vger.kernel.org/majordomo-info.html

If you can reproduce the problem with an upstream kernel, this is the
right place to debug it.  We'd need a complete dmesg log and "lspci
-vv" output to start with.

If the problem only happens with SUSE, then you'd want to work with
SUSE to figure it out.

Bjorn
