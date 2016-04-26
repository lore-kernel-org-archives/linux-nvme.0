From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 26 Apr 2016 04:54:53 -0700
Subject: Namespace non removal in case of active namespaces list scanning
In-Reply-To: <1206539106.713731461067307629.JavaMail.weblogic@ep2mlwas08c>
References: <1206539106.713731461067307629.JavaMail.weblogic@ep2mlwas08c>
Message-ID: <20160426115453.GC21668@infradead.org>

On Tue, Apr 19, 2016@12:01:48PM +0000, Sunad Bhandary S wrote:
> The following is a case where namespaces are not removed from host on receipt of namespace detach command.
> 
> In case of scanning of the active namespace list supported by 1.1 controllers and above,
> In scan_ns_list, we break out when we a find nsid with 0. 
> If that nsid was the particular one which was deleted, then we are wrongly skipping the removal of the namespace from the host. 
> 
> Also namespaces that exceed the device's reported number of namespaces (ex: after firmware reset) need to be removed from the host
> 
> The following diff is a fix by ensuring the deletion by introducing an extra validation scan to remove inactive name spaces following of the approach of the case without the active namespace list scanning.
> I would send out a patch if the current approach is acceptable. 

I think you can simply call the code to remove the post-nn namespaces
to nvme_scan_work as it's common to both scanning methods.  Also I think
the name nvme_remove_invalid_ns is misleading as it removes multiple
namespaces, and we use the _ns postfix for functions dealing with
a single namespace.
