From: jvbockel@gmail.com (John Van Bockel)
Date: Wed, 21 Nov 2018 15:19:46 -0600
Subject: Two M.2 NVMe drives with same NQN, one gets removed
In-Reply-To: <20181119170048.GC26595@localhost.localdomain>
References: <CAGmwwfeJEVkw2uf1oVoEYgNtuLPRrDqWHXQi-KXTdofsUdH2Dg@mail.gmail.com>
 <20181117013337.GA23062@localhost.localdomain>
 <CAGmwwfc=g+4h12qMBvRVJoE66Z70kzzfkabjyxLC=d7LZp627A@mail.gmail.com>
 <20181119170048.GC26595@localhost.localdomain>
Message-ID: <CAGmwwffLJfQYAvTF_ShEmjLvLyRfA0W3hnPMwfZzonZXDtgE1Q@mail.gmail.com>

Hi Keith,

I updated to version 004X of the 760p firmware and all appears to be working.
Thanks a bunch for steering me in the right direction.  Some results follow, in
case you're interested.

Thanks
jvbockel at gmail.com

# dmesg | grep -i nvme
[    3.475727] nvme nvme0: pci function 0000:72:00.0
[    3.475798] nvme nvme1: pci function 0000:73:00.0
[    3.585705] nvme nvme1: missing or invalid SUBNQN field.
[    3.588561]  nvme0n1: p1 p2
[    3.688492] nvme nvme0: missing or invalid SUBNQN field.
[    3.690815]  nvme1n1: p1 p2 p3 p4

# nvme list
Node             SN                   Model
        Namespace Usage                      Format           FW Rev
---------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------
/dev/nvme0n1     BTHH81850BX31P0E     INTEL SSDPEKKW010T8
        1           1.02  TB /   1.02  TB    512   B +  0 B   004X
/dev/nvme1n1     BTHH81850C8W1P0E     INTEL SSDPEKKW010T8
        1           1.02  TB /   1.02  TB    512   B +  0 B   004X

# nvme list-subsys
nvme-subsys0 - NQN=nqn.2014.08.org.nvmexpress:80868086BTHH81850BX31P0E
   INTEL SSDPEKKW010T8
\
 +- nvme1 pcie 0000:73:00.0
nvme-subsys1 - NQN=nqn.2014.08.org.nvmexpress:80868086BTHH81850C8W1P0E
   INTEL SSDPEKKW010T8
\
 +- nvme0 pcie 0000:72:00.0


On Mon, Nov 19, 2018@11:04 AM Keith Busch <keith.busch@intel.com> wrote:
>
> On Sun, Nov 18, 2018@10:55:11AM -0800, John Van Bockel wrote:
> > That's good news and very much appreciate the information and all
> > that you do for the open source community.  Is this an update for the
> > 760p NVMe drives or instead a UEFI update for the NUC8i7HVK?
> > Either way, good news.  Just wondering which I'm keeping an eye out
> > for.
>
> It's a 760p update, and looks like it was released earlier this month:
>
>   https://downloadcenter.intel.com/download/28320/Known-Issue-Intel-SSD-760p-Pro-7600p-Series-SubNQN-Conflict-on-Linux
>
> Sorry I missed that update, otherwise I could have sent you that link
> last week.
