From: helen.koike@collabora.co.uk (Helen Koike)
Date: Thu,  5 May 2016 12:24:31 -0300
Subject: [PATCH v2 RFC] nvme: improve performance for virtual NVMe devices
In-Reply-To: <1460657059-21214-1-git-send-email-helen.koike@collabora.co.uk>
References: <1460657059-21214-1-git-send-email-helen.koike@collabora.co.uk>
Message-ID: <1462461871-11316-1-git-send-email-helen.koike@collabora.co.uk>

Hi,

I am re-sending the proposition of the Set Doorbell/EventIdx memory command in plain text to be easier to review.

It can also be viewed here:
	https://people.collabora.com/~koike/nvme-set-doorbel-mem-v2.odt

Changes since v1: 
	- TODO about the unset command removed
	- Add text 5.18 specifying that the command is not retained through resets

Helen

-----
All referenced figures and sections indexes refers to the NVMe specification Revision 1.2a, October 23, 2015.

Proposal modifications:

=============================================================
* Add admin command in Figure 40 as shown below
=============================================================

Figure 40: Opcodes for Admin Commands
+---------+----------+-----------+----------+------+------------------+-----------------------------+
| Generic | Function |    Data   | Combined | O/M1 | Namespace        |          Command            |
| Command |          | Transfer4 | opcode2  |      | Identifier Used3 |                             |
+---------+----------+-----------+----------+------+------------------+-----------------------------+
|   ...   |   ...    |    ...    |    ...   |  ... |       ...        |            ...              |
+---------+----------+-----------+----------+------+------------------+-----------------------------+
|   0b    |    ?     |    11b    |    16h   |   O  |        No        | Set Doorbel/EventIdx Memory |
+---------+----------+-----------+----------+------+------------------+-----------------------------+

=============================================================
* Add a sub-section in 5 Admin Command Set as shown below:
=============================================================

5.18 Set Doorbell/EventIdx memory

The Set Doorbell/Eventidx memory command is used to reduce the number of MMIO
writes to the doorbell registers by ?remapping? the registers in a buffer in
the host, which can improve performances mainly in virtualized environments
where MMIOs are costly.
The host shall provide two buffers (Doorbell memory, updated by the host, and
EventIdx memory, updated by the controller) which mimic the doorbell structure
defined in section 3.1 and indicated in Figure (5.18.Figure1).
The host should update the doorbell memory instead of updating the doorbell
registers as usual, if the value written in memory pass the eventIdx which
refers to the same Submission/Completion Queue, then the doorbell register
should be updated.

The host shall provide a memory as indicated in (5.18.Figure1) with enough
size according to the parameter y given, all queue with QID greater then y will
not be affected and shall use the classic doorbell registers.

The controller might read from the Doorbell memory buffer and update the EventIdx
buffer before the host writes to the Doorbell register, it is implementation
specific when the controller perform those actions.
The Set Doorbell/EventIdx memory command is not retained if a controller reset
occurs.

Note: The consumer and producer shall take queue wrap conditions into account.

Figure (5.18.Figure1) Doorbell/EventIdx Memory buffer structure
+------------------------------+----------------------------+-----------------------------------------+
| Start (Offset in the buffer) | End (Offset in the buffer) |              Description                |
+------------------------------+----------------------------+-----------------------------------------+
|            00h               |            03h             | Submission Queue 0 Tail Mem Doorbell or |
|                              |                            | EventIdx (Admin)                        |
+------------------------------+----------------------------+-----------------------------------------+
|         00h + (1 *           |         03h + (1 *         | Completion Queue 0 Head Mem Doorbell or |
|      (4 << CAP.DSTRD))       |      (4 << CAP.DSTRD))     | EventIdx (Admin)                        |
+------------------------------+----------------------------+-----------------------------------------+
|         00h + (2 *           |         03h + (2 *         | Submission Queue 1 Tail Mem Doorbell or |
|      (4 << CAP.DSTRD))       |      (4 << CAP.DSTRD))     | EventIdx                                |
+------------------------------+----------------------------+-----------------------------------------+
|         00h + (3 *           |         03h + (3 *         | Completion Queue 1 Head Mem Doorbell or |
|      (4 << CAP.DSTRD))       |      (4 << CAP.DSTRD))     | EventIdx                                |
+------------------------------+----------------------------+-----------------------------------------+
|            ...               |            ...             |                 ...                     |
+------------------------------+----------------------------+-----------------------------------------+
|        00h + (2y *           |        03h + (2y *         | Submission Queue y Tail Mem Doorbell or |
|      (4 << CAP.DSTRD))       |      (4 << CAP.DSTRD))     | EventIdx                                |
+------------------------------+----------------------------+-----------------------------------------+
|     00h + ((2y + 1) *        |     03h + ((2y + 1) *      | Completion Queue y Head Mem Doorbell or |
|      (4 << CAP.DSTRD))       |      (4 << CAP.DSTRD))     | EventIdx                                |
+------------------------------+----------------------------+-----------------------------------------+


Figure (5.18.Figure 2): Set Doorbell/EventIdx Memory - PRP Entry 1
+-------+-------------------------------------------------------------------+
| Bit   | Description                                                       |
+-------+-------------------------------------------------------------------+
| 63:00 | PRP Entry 1 (PRP1): This field contains the first PRP entry,      |
|       | specifying the start of the Doorbell memory data buffer.          |
+-------+-------------------------------------------------------------------+

Figure (5.18.Figure 3): Set Doorbell/EventIdx Memory - PRP Entry 2
+-------+-------------------------------------------------------------------+
| Bit   | Description                                                       |
+-------+-------------------------------------------------------------------+
| 63:00 | PRP Entry 2 (PRP2): This field contains the second PRP entry.     |
|       |  Refer to Figure 11 for the definition of this field.             |
+-------+-------------------------------------------------------------------+

Figure (5.18.Figure 4): Set Doorbell/EventIdx Memory - Command Dword 10 and Command Dword 11
+-------+-------------------------------------------------------------------+
| Bit   | Description                                                       |
+-------+-------------------------------------------------------------------+
| 63:00 | EventIdx Data Pointer (EDPTR): This field contain the equivalent  |
|       | PRP1 and PRP2 for the EventIdx data buffer. Command Dword 10      |
|       | contain the PRP1 and Command Dword 11 the PRP2.                   |
+-------+-------------------------------------------------------------------+

Figure (5.18.Figure 5): Set Doorbell/EventIdx Memory - Command Dword 12
+-------+-------------------------------------------------------------------+
| Bit   | Description                                                       |
+-------+-------------------------------------------------------------------+
| 31:00 | Number of queues (NQS): The y value as indicated in (5.18.Figure1)|
|       | which defines the minimum size of the data buffers and the number |
|       | of queues to cover. This is a 0?s based value.                    |
+-------+-------------------------------------------------------------------+

5.18.1 Command Completion

If the command is completed, then the controller shall post a completion queue
entry to the Admin Completion Queue indicating the status for the command. 
Set Doorbell/EventIdx memory command specific status values are defined in
Figure (5.18.Figure 6).

Figure (5.18.Figure 6): Set Doorbell/EventIdx Memory ? Command Specific Status Values
+-------+-------------------------------------------------------------------+
| Value | Description                                                       |
+-------+-------------------------------------------------------------------+
| 0Ch   | Invalid memory address                                            |
+-------+-------------------------------------------------------------------+

=============================================================
* Add the following option in the Identify commands Figure 90
=============================================================

+---------+-----+-------------------------------------------------------------+
| Bytes   | O/M |                  Description                                |
+---------+-----+-------------------------------------------------------------+
|   ...   | ... |                      ...                                    |
+---------+-----+-------------------------------------------------------------+
|         Admin Command Set Attributes & Optional Controller Capabilities     |
+---------+-----+-------------------------------------------------------------+
| 257:256 |  M  |                      ...                                    |
|         |     | Bit 4 if set to '1' then the controller supports the Set    |
|         |     | Doorbell/EventIdx Memory command. If cleared to '0' then the|
|         |     | controller does not support the  Set Doorbell/EventIdx      |
|         |     | Memory command.                                             |
|         |     |                      ...                                    |
+---------+-----+-------------------------------------------------------------+
|   ...   | ... |                      ...                                    |
+---------+-----+-------------------------------------------------------------+
-- 
1.9.1
