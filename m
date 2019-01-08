From: gabe.frangakis@gmail.com (Gabriel Frangakis)
Date: Tue, 8 Jan 2019 11:55:03 -0500
Subject: NVME_QUIRK_IGNORE_DEV_SUBNQN patch?
In-Reply-To: <CAP5yZ1ikNPCkX74aVcadB8hEP_Vr0VTgBAHZ8JuFmy_+oQrGNQ@mail.gmail.com>
References: <CAP5yZ1ikNPCkX74aVcadB8hEP_Vr0VTgBAHZ8JuFmy_+oQrGNQ@mail.gmail.com>
Message-ID: <CAP5yZ1hRjj_DVJKzKXtk-Fh5Vkz+aUekkz9RAbRGDCJ0D801Fw@mail.gmail.com>

Bumping this. I can also try submitting as a patch but as a newcomer
didn't think it was appropriate

On Thu, Jan 3, 2019 at 10:25 AM Gabriel Frangakis
<gabe.frangakis@gmail.com> wrote:
>
> Back in November, there was a discussion about a firmware issue with
> Intel NVME drives
> (http://lists.infradead.org/pipermail/linux-nvme/2018-November/021366.html).
> Intel has issued a firmware update to address this, but there's no
> telling when OEMs will pick it up and incorporate it.
>
> It seemed that a potential fix was created by John Dingwall to ignore
> the sub NQN, and I was wondering if there were plans to submit this as
> a patch to the kernel. I'm unfamiliar with how that whole process
> works, so apologies if I'm out of line.
