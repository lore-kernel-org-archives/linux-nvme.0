From: asrivastava014@gmail.com (Ankur Srivastava)
Date: Tue, 18 Apr 2017 11:28:02 +0530
Subject: [NVMeF]: Multipathing setup for NVMeF
In-Reply-To: <20170412150037.GC623@localhost.localdomain>
References: <CAJvSebub-HnRnCpE-z2aTxmkrJLTo7=c9FoBncgJ+BZ_PUYsMQ@mail.gmail.com>
 <20170412150037.GC623@localhost.localdomain>
Message-ID: <CAJvSebvx13-T5KEJ-VLwHZc-qzTcoJdTL13bs__8hHSVbsQuyA@mail.gmail.com>

Thanks for the useful pointers.

One more query, I have inserted the udev rule for nvme in the file
"/etc/udev/rules.d/10-knem.rules" the rule as "SUBSYSTEM=="nvme",
KERNEL=="nvme*[0-9]n*[0-9]", ENV{DEVTYPE}=="disk", ATTRS{wwid}=="?*",
ENV{ID_WWN}="$attr{10}" here I suspect ID_WWN could be nsid, but not
sure but I am getting a very absurd wwid in the file
"/sys/class/nvme-fabrics/ctl/nvme0/nvme0n1/wwid" the wwid I am getting
is "nvme.0000-6161353331646636333736376632363000-4c696e75780000000000000000000000000000000000000000000000000000000000000000000000-0000000a"
which could be linux generated, So my queries are...

1) Where I can get the correct wwid for nvme over fabrics, is it the
nsid or anything else.

2) Where I could get the below information from NVMeF perspective to
populate the "/etc/multipath.conf" file

devices {
 # Enable multipathing for NVMeF Disks.
  device {
          vendor          "????"
          product         "????"
          path_grouping_policy "????"
          prio            ????
          features        "????"
          no_path_retry   ????
          path_checker    ????
          rr_min_io       ????
          failback         ????
          fast_io_fail_tmo  ????
          dev_loss_tmo      ????
          uid_attribute = "ID_WWN" ????

  }
}


Please correct me if I am doing something wrong or missing any step in
configuring multipath feature for NVMeF.

Thanks in advance!


Best Regards
Ankur

On Wed, Apr 12, 2017@8:30 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, Apr 12, 2017@02:58:05PM +0530, Ankur Srivastava wrote:
>> I have connected my Initiator to both the ports of Ethernet
>> Adapter(Target) to get 2 IO Paths, from the above data "/dev/nvme0n1"
>> is path 1 and "/dev/nvme1n1" is path 2 for the same namespace.
>>
>> Note: I am using Null Block device on the Target Side.
>>
>> But still the multipath is showing an error ie no path to Host for All
>> the NVMe Drives mapped on the Initiator. Does multipathd supports NVMe
>> over Fabric ??
>> Or what I am missing from configuration side ??
>>
>> Thanks in advance!!
>
> I think you need a udev rule to export the wwn like
>
>   KERNEL=="nvme*[0-9]n*[0-9]", ENV{DEVTYPE}=="disk", ATTRS{wwid}=="?*", ENV{ID_WWN}="$attr{wwid}"
>
> And multipathd conf needs to use that attribute for uid for NVME,
> uid_attribute = "ID_WWN".
>
> These should be there by default if you've very recent versions (within
> the last 6 weeks) of multipath-tools and systemd installed.
>
> If your kernel has CONFIG_SCSI_DH set, you'll also need this recent
> kernel commit:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=857de6e00778738dc3d61f75acbac35bdc48e533
