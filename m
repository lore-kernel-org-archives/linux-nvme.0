From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 12 Mar 2013 18:23:22 -0400
Subject: [PATCH 3/4] NVMe: End-to-end data protection
In-Reply-To: <OF4D215762.7078BEB8-ON86257B2C.004F99F8-86257B2C.00538982@hgst.com>
 (David Darrington's message of "Tue, 12 Mar 2013 10:12:26 -0500")
References: <OF4D215762.7078BEB8-ON86257B2C.004F99F8-86257B2C.00538982@hgst.com>
Message-ID: <yq1620wqmud.fsf@sermon.lab.mkp.net>

>>>>> "David" == David Darrington <David.Darrington at hgst.com> writes:

David> I figured that hte block layer (or perhaps above) could setup a
David> bio_integrity_payload. In which case, the bio's received by the
David> driver would already include bips and woudl simply write the
David> meta-data to the drive.

Correct.

-- 
Martin K. Petersen	Oracle Linux Engineering
