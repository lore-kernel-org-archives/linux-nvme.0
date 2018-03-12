From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Mon, 12 Mar 2018 11:09:34 -0700
Subject: [pci PATCH v5 1/4] pci: Add pci_sriov_configure_simple for PFs
 that don't manage VF resources
In-Reply-To: <20180312174012.GE18494@localhost.localdomain>
References: <20180312171813.3487.94803.stgit@localhost.localdomain>
 <20180312172031.3487.20651.stgit@localhost.localdomain>
 <20180312174012.GE18494@localhost.localdomain>
Message-ID: <CAKgT0UdWc=Sz-xgd4H3bTDt5d17=-PY8VPWz6A3mAciWV6=97w@mail.gmail.com>

On Mon, Mar 12, 2018@10:40 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Mon, Mar 12, 2018@10:21:29AM -0700, Alexander Duyck wrote:
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 024a1beda008..9cab9d0d51dc 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1953,6 +1953,7 @@ static inline void pci_mmcfg_late_init(void) { }
>>  int pci_vfs_assigned(struct pci_dev *dev);
>>  int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
>>  int pci_sriov_get_totalvfs(struct pci_dev *dev);
>> +int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn);
>>  resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
>>  void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
>>  #else
>
> I recommend stubbing 'pci_sriov_configure_simple' or defining it to
> NULL in the '#else' section here so you don't need to repeat the "#ifdef
> CONFIG_PCI_IOV" in each driver wishing to use this function. Otherwise
> looks fine to me.

My concern with defining it as NULL is that somebody may end up
calling it in the future directly and that may end up causing issues.
One thought I have been debating is moving it to a different file. I
am just not sure where the best place to put something like this would
be. I could move this function to drivers/pci/pci.c if everyone is
okay with it and then I could just strip the contents out by wrapping
them in a #ifdef instead.
