From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 17 Jan 2014 14:00:32 -0700
Subject: [PATCH v2 0/9] Phase out pci_enable_msi_block()
In-Reply-To: <cover.1389904166.git.agordeev@redhat.com>
References: <cover.1389904166.git.agordeev@redhat.com>
Message-ID: <CAErSpo5ztnyyceeN38XzLasLV6eJqdbqEV0viPp3Af8U=ts23w@mail.gmail.com>

On Fri, Jan 17, 2014@9:02 AM, Alexander Gordeev <agordeev@redhat.com> wrote:
> This series is against "next" branch in Bjorn's repo:
> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>
> Changes from v1 to v2:
>   - added a regression fix "ahci: Fix broken fallback to single
>     MSI mode" as patch 1/9;
>   - the series is reordered to move the regression fix in front;
>   - at Bjorn's request pci_enable_msi() is un-deprecated;
>   - as result, pci_enable_msi_range(pdev, 1, 1) styled calls
>     rolled back to pci_enable_msi(pdev);
>   - nvme bug fix moved out as a separate patch 5/9 "nvme: Fix
>     invalid call to irq_set_affinity_hint()"
>   - patches changelog elaborated a bit;
>
> Bjorn,
>
> As the release is supposedly this weekend, do you prefer
> the patches to go to your tree or to individual trees after
> the release?

I'd be happy to merge them, except for the fact that they probably
wouldn't have any time in -next before I ask Linus to pull them.  So
how about if we wait until after the release, ask the area maintainers
to take them, and if they don't take them, I'll put them in my tree
for v3.15?

Bjorn
