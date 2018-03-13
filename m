From: ddutile@redhat.com (Don Dutile)
Date: Tue, 13 Mar 2018 12:17:34 -0400
Subject: [pci PATCH v5 3/4] ena: Migrate over to unmanaged SR-IOV support
In-Reply-To: <1520953463.20126.15.camel@infradead.org>
References: <20180312171813.3487.94803.stgit@localhost.localdomain>
 <20180312172309.3487.76690.stgit@localhost.localdomain>
 <1520928772.28745.53.camel@infradead.org>
 <CAKgT0UdkUSsHQC7CpJQ0CT77AD8k7P-HeeomWXNJQ-Ek4dJRMQ@mail.gmail.com>
 <1520953463.20126.15.camel@infradead.org>
Message-ID: <3d291517-fc7d-53ea-66b4-27137bdb14e5@redhat.com>

On 03/13/2018 11:04 AM, David Woodhouse wrote:
> On Tue, 2018-03-13@07:51 -0700, Alexander Duyck wrote:
> 
>> Actually the suggestion I had from Don Dutile was that we should be
>> looking at creating a pci-stub like driver specifically for those type
>> of devices, but without the ability to arbitrarily assign devices.
>> Basically we have to white-list it in one device at a time for those
>> kind of things.
> 
> It's still not clear what the point of that would be.
> 
A PF-stub to do device-assignment(-like) ops preserves the current security model,
and allows one to add pci-quirks at a device-level as well -- when the usual ACS
structs aren't properly added for a device, which happens quite frequently -- which
retains that common workaround as well.
Yet-another-method for VF assignment w/o even a simple PF driver stub
created multiple failure cases/configs when we were hashing the multiple options
a few weeks ago.
It's just simpler to implement a PF stub w/VF enablement ... b/c it's simple...

>> If you have the device ID of the thing you wanted to have work with
>> pci-stub before I could look at putting together a quick driver and
>> adding it to this set.
> 
> 1d0f:0053 would be an example.
> 
