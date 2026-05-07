-- 1. Show every flight with its predecessor flight number — use LEFT JOIN so origin flights (no predecessor) appear with NULL

SELECT
	f.flight_no as flight,
	p.flight_no as prev_flight
FROM flights f
LEFT JOIN flights p ON f.prev_flight_id = p.id;

-- 2. Show only flights that directly follow 'TK101' (i.e. where the predecessor flight is TK101)

SELECT
	f.flight_no as flight,
	p.flight_no as prev_flight
FROM flights f
LEFT JOIN flights p ON f.prev_flight_id = p.id
WHERE p.flight_no = 'TK101';

-- 3. Count how many onward connections each flight has (how many flights list it as predecessor), sorted descending

SELECT
	f.flight_no,
	count(p.id) as onward_connections
FROM flights f
LEFT JOIN flights p ON p.prev_flight_id = f.id
GROUP BY f.flight_no
ORDER BY onward_connections DESC;

-- 4. Find flights where the predecessor's destination doesn't match the current flight's origin — a data-inconsistency check

SELECT
	f.flight_no,
	p.flight_no as previos_flight,
	p.destination as predecessors_destination,
	f.origin as flights_origin
FROM flights f
LEFT JOIN flights p ON f.prev_flight_id = p.id
WHERE p.destination != f.origin;
