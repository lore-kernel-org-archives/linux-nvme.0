From: keith.busch@intel.com (Keith Busch)
Date: Tue, 8 Jan 2019 10:19:40 -0700
Subject: NVME_QUIRK_IGNORE_DEV_SUBNQN patch?
In-Reply-To: <CAP5yZ1hRjj_DVJKzKXtk-Fh5Vkz+aUekkz9RAbRGDCJ0D801Fw@mail.gmail.com>
References: <CAP5yZ1ikNPCkX74aVcadB8hEP_Vr0VTgBAHZ8JuFmy_+oQrGNQ@mail.gmail.com>
 <CAP5yZ1hRjj_DVJKzKXtk-Fh5Vkz+aUekkz9RAbRGDCJ0D801Fw@mail.gmail.com>
Message-ID: <20190108171940.GE18014@localhost.localdomain>

On Tue, Jan 08, 2019@11:55:03AM -0500, Gabriel Frangakis wrote:
> Bumping this. I can also try submitting as a patch but as a newcomer
> didn't think it was appropriate

New contributers are certainly welcome.

I think James' patch was fine, but I don't see that it was ever posted
as a proper patch that could be applied. I'll send one on his behalf
with a review tag.

> On Thu, Jan 3, 2019 at 10:25 AM Gabriel Frangakis
> <gabe.frangakis@gmail.com> wrote:
> >
> > Back in November, there was a discussion about a firmware issue with
> > Intel NVME drives
> > (http://lists.infradead.org/pipermail/linux-nvme/2018-November/021366.html).
> > Intel has issued a firmware update to address this, but there's no
> > telling when OEMs will pick it up and incorporate it.
> >
> > It seemed that a potential fix was created by John Dingwall to ignore
> > the sub NQN, and I was wondering if there were plans to submit this as
> > a patch to the kernel. I'm unfamiliar with how that whole process
> > works, so apologies if I'm out of line.
