From: sbates@raithlin.com (Stephen  Bates)
Date: Wed, 9 May 2018 12:35:56 +0000
Subject: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <20180508180157.7c7b393f@w520.home>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <CAPcyv4g+5N_n03J-VhmJfrr60Sqk95ZapLKBkwSsGvV4nQ+ZRw@mail.gmail.com>
 <64C231F5-DE36-415F-B308-3A423B0BBACB@raithlin.com>
 <15433946-f7f5-f610-4e80-380fb59920e5@redhat.com>
 <3C9FB262-A93C-4C8F-B1E0-85C6D6F78BC2@raithlin.com>
 <c5f30ced-7bbf-9420-db1a-72519fc78b3a@redhat.com>
 <20180508180157.7c7b393f@w520.home>
Message-ID: <B5BFCF39-6BB4-4E45-B805-C8FCC8B79EF3@raithlin.com>

Hi Alex and Don

>    Correct, the VM has no concept of the host's IOMMU groups, only the
>   hypervisor knows about the groups, 

But as I understand it these groups are usually passed through to VMs on a pre-group basis by the hypervisor? So IOMMU group 1 might be passed to VM A and IOMMU group 2 passed to VM B. So I agree the VM is not aware of IOMMU groupings but it is impacted by them in the sense that if the groupings change the PCI topology presented to the VM needs to change too.

Stephen
